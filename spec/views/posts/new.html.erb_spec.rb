RSpec.describe "posts/new", type: :feature do
  before(:each) { visit new_post_path }

  describe "a blank form" do
    it "does not render an error list" do
      expect(page).not_to have_selector("#error_explanation")
    end

    it "does not render error fields" do
      expect(page).not_to have_selector(".field_with_errors")
    end
  end

  context "invalid submissions" do
    let(:invalid_attributes) do
      { title: nil, category: "Speculative Fiction", content: "too short" }
    end

    before(:each) do
      Post.create(
        title: invalid_attributes[:title],
        category: "Fiction",
        content: "Lorem ipsum dolar sit amet, consectetur adipiscing elit."
      )

      visit new_post_path
      fill_in "Category", with: invalid_attributes[:category]
      fill_in "Content", with: invalid_attributes[:content]
      click_button "Create"
    end

    it "renders an error list" do
      expect(all("#error_explanation li").size).to eq(3)
    end

    it "prefills fields" do
      expect(find("input[name=title]").value).to be_empty
      expect(find("input[name=category]").value).to eq(invalid_attributes[:category])
      expect(find("input[name=content]").value).to eq(invalid_attributes[:content])
    end

    it "has error class on bad fields" do
      expect(page).to have_css(".field_with_errors input[name=title]")
      expect(page).to have_css(".field_with_errors input[name=category]")
      expect(page).to have_css(".field_with_errors input[name=content]")
    end
  end
end
