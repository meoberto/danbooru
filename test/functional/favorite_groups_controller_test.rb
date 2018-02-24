require 'test_helper'

class FavoriteGroupsControllerTest < ActionDispatch::IntegrationTest
  context "The favorite groups controller" do
    setup do
      @user = create(:user)
      CurrentUser.as(@user) do
        @favgroup = create(:favorite_group)
      end
    end

    context "index action" do
      should "render" do
        get favorite_groups_path
        assert_response :success
      end
    end

    context "show action" do
      should "render" do
        get favorite_group_path(@favgroup)
        assert_response :success
      end
    end

    context "new action" do
      should "render" do
        get_authenticated new_favorite_group_path, @user
        assert_response :success
      end
    end

    context "create action" do
      should "render" do
        post_authenticated favorite_groups_path, @user, params: { favorite_group: FactoryBot.attributes_for(:favorite_group) }
        assert_redirected_to favorite_groups_path
      end
    end

    context "edit action" do
      should "render" do
        get_authenticated edit_favorite_group_path(@favgroup), @user
        assert_response :success
      end
    end

    context "update action" do
      should "render" do
        params = { favorite_group: { name: "foo" } }
        put_authenticated favorite_group_path(@favgroup), @user, params: params
        assert_redirected_to @favgroup
        assert_equal("foo", @favgroup.reload.name)
      end
    end

    context "destroy action" do
      should "render" do
        delete_authenticated favorite_group_path(@favgroup), @user
        assert_redirected_to favorite_groups_path
      end
    end

    context "add_post action" do
      should "render" do
        CurrentUser.as(@user) do
          @post = FactoryBot.create(:post)
        end

        put add_post_favorite_group_path(@favgroup), @user, params: {post_id: post.id, format: "js"}
        assert_response :success
        assert_equal([post.id], favgroup.reload.post_id_array)
      end
    end
  end
end
