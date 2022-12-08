require "application_system_test_case"

class AlbumsTest < ApplicationSystemTestCase
  setup do
    @album = albums(:one)
  end

  test "visiting the index" do
    visit albums_url
    assert_selector "h1", text: "Albums"
  end

  test "should create album" do
    visit albums_url
    click_on "New album"

    fill_in "Album length", with: @album.album_length
    fill_in "Artist", with: @album.artist
    fill_in "Genre", with: @album.genre
    fill_in "Language", with: @album.language
    fill_in "Released", with: @album.released
    fill_in "Title", with: @album.title
    click_on "Create Album"

    assert_text "Album was successfully created"
    click_on "Back"
  end

  test "should update Album" do
    visit album_url(@album)
    click_on "Edit this album", match: :first

    fill_in "Album length", with: @album.album_length
    fill_in "Artist", with: @album.artist
    fill_in "Genre", with: @album.genre
    fill_in "Language", with: @album.language
    fill_in "Released", with: @album.released
    fill_in "Title", with: @album.title
    click_on "Update Album"

    assert_text "Album was successfully updated"
    click_on "Back"
  end

  test "should destroy Album" do
    visit album_url(@album)
    click_on "Destroy this album", match: :first

    assert_text "Album was successfully destroyed"
  end
end
