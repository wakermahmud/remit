class HomeController < ApplicationController
  include ListingStudies

  def index
    # rubocop:disable Style/MultilineOperationIndentation
    @studies = get_filtered_studies.order(@ordering).
                                    page(params[:page]).
                                    per(10)
    # rubocop:enable Style/MultilineOperationIndentation
  end
end
