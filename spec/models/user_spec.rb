require "rails_helper"

RSpec.describe User, type: :model do
  # Columns
  it do
    is_expected.to have_db_column(:name).of_type(:text).
      with_options(null: false)
  end
  it { is_expected.to have_db_column(:msf_location_id).of_type(:integer) }
  it { is_expected.to have_db_column(:external_location).of_type(:text) }
  it do
    is_expected.to have_db_column(:is_admin).of_type(:boolean).
      with_options(null: false, default: false)
  end

  # Associations
  it { is_expected.to belong_to(:msf_location).inverse_of(:users) }
  it do
    is_expected.to have_many(:principal_investigator_studies).
      inverse_of(:principal_investigator).class_name(:Study)
  end
  it do
    is_expected.to have_many(:research_manager_studies).
      inverse_of(:research_manager).class_name(:Study)
  end
  it do
    is_expected.to have_many(:created_activities).
      class_name("PublicActivity::Activity")
  end
  it do
    is_expected.to have_many(:involved_activities).
      class_name("PublicActivity::Activity")
  end

  # Validation
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_inclusion_of(:is_admin).in_array([true, false]) }

  context "when the when msf_location field is 'External'" do
    let(:external_location) { MsfLocation.find_by_name("External") }

    it "should be invalid when the external_location field is nil" do
      user = FactoryGirl.build(:user)
      user.msf_location = external_location
      user.external_location = nil
      expect(user).to be_invalid
    end

    it "should be invalid when the external_location field is empty" do
      user = FactoryGirl.build(:user)
      user.msf_location = external_location
      user.external_location = ""
      expect(user).to be_invalid
    end

    it "should be valid when we set the external_location field" do
      user = FactoryGirl.build(:user)
      user.msf_location = external_location
      user.external_location = "some external location"
      expect(user).to be_valid
    end
  end

  context "when the user has owned some activities", :truncation do
    let(:user) { FactoryGirl.create(:user) }
    let(:study) { FactoryGirl.create(:study) }

    before do
      PublicActivity.enabled = true
      study.create_activity("title_changed", owner: user)
    end

    after do
      PublicActivity.enabled = false
    end

    it "should not allow the user to be deleted" do
      expected_error = ActiveRecord::DeleteRestrictionError
      expect { user.destroy }.to raise_error(expected_error)
    end
  end

  context "when the user is involved in some activities", :truncation do
    let(:user) { FactoryGirl.create(:user) }
    let(:study) { FactoryGirl.create(:study) }

    before do
      PublicActivity.enabled = true
      study.create_activity("principal_investigator_id_changed",
                            recipient: user)
    end

    after do
      PublicActivity.enabled = false
    end

    it "deletes the activities if the user is deleted" do
      expect { user.destroy }.to change(study.activities, :count).by(-1)
    end
  end
end
