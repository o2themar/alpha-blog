require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password")
    @category = Category.create(name: "Sports")
  end

  test 'Create new article without logging in' do
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: "New article", description: "New article description", category_ids: [1] } }
    end
    assert_redirected_to root_path
    assert_equal "You must be logged in to perform that action", flash[:danger]
  end

  test 'Create new article while logged in' do
    sign_in_as(@user, "password")
    get new_article_path
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "New article", description: "New article description", category_ids: [1] } }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_response :success
  end


end
