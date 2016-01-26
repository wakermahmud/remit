# encoding: utf-8
require "rails_helper"
require "support/activity_view_shared_examples"

RSpec.describe "public_activity/study/_document_added.html.erb", type: :view do
  let(:partial) { "public_activity/study/document_added" }
  let(:study) { FactoryGirl.create(:study) }
  let(:document) { FactoryGirl.create(:document, study: study) }
  let(:user) { FactoryGirl.create(:user) }
  let(:activity_without_owner) do
    study.create_activity :document_added,
                          owner: nil,
                          related_content: document
  end
  let(:activity_with_owner) do
    study.create_activity :document_added,
                          owner: user,
                          related_content: document
  end

  let(:expected_class) { "timeline__item--affirmative" }
  let(:expected_title) { "#{document.document_type.name} added" }
  let(:expected_description) do
    "Read #{document.document_type.name.downcase} »"
  end
  let(:expected_description_class) { ".timeline__item__details" }

  before do
    PublicActivity.enabled = true
  end

  after do
    PublicActivity.enabled = false
  end

  it_behaves_like "an activity view"
end
