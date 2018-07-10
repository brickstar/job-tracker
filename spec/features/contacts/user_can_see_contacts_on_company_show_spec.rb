require 'rails_helper'

describe 'user visits company' do
  before(:each) do
    @company = Company.create!(name: 'Aetna')
    @contact = @company.contacts.create!(full_name: "oihsi",
                              email: 'adf',
                              position: 'lkjer')
  end

  it "can create and see a contact" do
    visit company_path(@company)

    fill_in "contact[full_name]", with: "murder jones"
    fill_in "contact[email]", with: "murderer@murderer.com"
    fill_in "contact[position]", with: "murderer"

    click_button "Create Contact"

    expect(current_path).to eq(company_path(@company))
    expect(page).to have_content("murder jones")
    expect(page).to have_content("murderer@murderer.com")
    expect(page).to have_content("murderer")
    expect(Contact.count).to eq(2)
  end

  describe "user deletes existing contact" do
    it "can delete a contact" do

      visit company_path(@company)

      click_link('delete')

      expect(Contact.all.empty?).to be(true)
    end
  end

  it 'can update a contact' do
    visit company_path(@company)

    click_on "edit"

    expect(current_path).to eq(edit_company_contact_path(@company, @contact))

    fill_in "contact[full_name]", with: "Developer"
    fill_in "contact[email]", with: "So fun!"
    fill_in "contact[position]", with: 'newpos'

    click_on "Update"

    expect(current_path).to eq(company_path(@company))
    expect(page).to have_content("Developer")
    expect(page).to have_content("So fun!")
    expect(page).to have_content("newpos")
    end
  end
