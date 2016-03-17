class DeliveryUpdatesController < ApplicationController
  include InvitingUsers

  before_action :set_study_from_study_id, only: [:new, :create]
  before_action :check_user_can_contribute_to_study, only: [:new, :create]

  def new
  end

  def create
    build_delivery_update
    if @delivery_update.save
      connect_update_to_invite
      set_success_message
    else
      set_error_message
    end
    render "new"
  end

  private

  def build_delivery_update
    @delivery_update = DeliveryUpdate.new(delivery_update_params)
    @delivery_update.study = @study
    @delivery_update.user = current_user
  end

  def connect_update_to_invite
    if @invite.present?
      @invite.delivery_update = @delivery_update
      @invite.save
    end
  end

  def delivery_update_params
    # rubocop:disable Metrics/LineLength
    params.require(:delivery_update).permit(:data_analysis_status_id,
                                            :data_collection_status_id,
                                            :interpretation_and_write_up_status_id,
                                            :comments)
    # rubocop:enable Metrics/LineLength
  end

  def set_success_message
    msg = "Delivery update created successfully.<br><br>"
    if pending_updates.any?
      msg += pending_updates_message(pending_updates)
    else
      msg += "You don't have any more studies you need to update!"
    end
    flash.now[:notice] = msg.html_safe
  end

  def pending_updates_message(pending_updates)
    msg = "You've also got the following studies you need to update:"
    pending_updates.each do |invite|
      msg += "<br><a href=\"#{pending_invite_link(invite)}\">" \
             "#{invite.study.title.truncate(30)}</a>"
    end
    msg
  end

  def set_error_message
    flash.now[:alert] = "Sorry, looks like we're missing something, can you " \
                        "double check?"
  end

  def pending_invite_link(invite)
    if @invite_token
      "#{new_study_delivery_update_path(invite.study)}?token=#{@invite_token}"
    else
      "#{new_study_delivery_update_path(invite.study)}"
    end
  end

  def pending_updates
    # Check for any other updates they should be creating
    pending_updates_sql = <<-SQL
      invited_user_id = ?
      AND delivery_update_id IS NULL
    SQL
    DeliveryUpdateInvite.where(pending_updates_sql, current_user.id)
  end

  def set_invited_user
    @invited_user = User.find_by_delivery_update_token(params[:token])
  end

  def set_invite
    # You can invite someone multiple times (in theory), so we just assume
    # they're responding to the latest invite.
    # rubocop:disable Style/MultilineOperationIndentation
    @invite = DeliveryUpdateInvite.where(study: @study,
                                         invited_user: @invited_user).
                                   order(created_at: :desc).
                                   take
    # rubocop:enable Style/MultilineOperationIndentation
  end
end