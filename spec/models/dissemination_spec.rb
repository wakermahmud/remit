require "rails_helper"

RSpec.describe Dissemination, type: :model do
  let!(:other_study_type) { FactoryGirl.create(:other_type) }
  let!(:other_internal_category) { FactoryGirl.create(:other_internal) }
  let!(:other_external_category) { FactoryGirl.create(:other_external) }

  # Columns
  it do
    is_expected.to have_db_column(:dissemination_category_id).
      of_type(:integer).
      with_options(null: false)
  end
  it do
    is_expected.to have_db_column(:details).of_type(:text).
      with_options(null: false)
  end
  it do
    is_expected.to have_db_column(:fed_back_to_field).of_type(:boolean).
      with_options(null: false)
  end
  it do
    is_expected.to have_db_column(:study_id).of_type(:integer).
      with_options(null: false)
  end
  it do
    is_expected.to have_db_column(:other_dissemination_category).of_type(:text)
  end

  # Associations
  it { is_expected.to belong_to(:study).inverse_of(:disseminations) }
  it do
    is_expected.to belong_to(:dissemination_category).
      inverse_of(:disseminations)
  end

  # Validations
  it { is_expected.to validate_presence_of(:study) }
  it { is_expected.to validate_presence_of(:dissemination_category) }
  it { is_expected.to validate_presence_of(:details) }
  it do
    is_expected.to validate_inclusion_of(:fed_back_to_field).
      in_array([true, false])
  end

  context "when dissemination_category is 'Other internal'" do
    it "should be invalid when the dissemination_category field is nil" do
      category = FactoryGirl.build(
        :dissemination,
        dissemination_category: other_internal_category,
        other_dissemination_category: nil)
      expect(category).to be_invalid
    end

    it "should be invalid when the dissemination_category field is empty" do
      category = FactoryGirl.build(
        :dissemination,
        dissemination_category: other_internal_category,
        other_dissemination_category: "")
      expect(category).to be_invalid
    end

    it "should be valid when we set the dissemination_category field" do
      category = FactoryGirl.build(
        :dissemination,
        dissemination_category: other_internal_category,
        other_dissemination_category: "some other category")
      expect(category).to be_valid
    end
  end

  context "when dissemination_category is 'Other external'" do
    it "should be invalid when the dissemination_category field is nil" do
      category = FactoryGirl.build(
        :dissemination,
        dissemination_category: other_external_category,
        other_dissemination_category: nil)
      expect(category).to be_invalid
    end

    it "should be invalid when the dissemination_category field is empty" do
      category = FactoryGirl.build(
        :dissemination,
        dissemination_category: other_external_category,
        other_dissemination_category: "")
      expect(category).to be_invalid
    end

    it "should be valid when we set the dissemination_category field" do
      category = FactoryGirl.build(
        :dissemination,
        dissemination_category: other_external_category,
        other_dissemination_category: "some other category")
      expect(category).to be_valid
    end
  end
end