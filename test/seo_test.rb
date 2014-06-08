require 'test_helper'

class SeoTest < ActionView::TestCase

  test "should populate meta using the path of the template as key" do
    render template: 'pages/index', layout: 'layouts/application'
    assert_select 'title', I18n.t('pages.index.title')
    assert_select "meta[content='#{I18n.t('pages.index.description')}']"
    assert_select "meta[content='#{I18n.t('pages.index.keywords')}']"
 
    render template: 'pages/other', layout: 'layouts/application'
    assert_select 'title', I18n.t('pages.other.title', name: 'other')
    assert_select "meta[content='#{I18n.t('pages.other.description', name: 'other')}']"
    assert_select "meta[content='#{I18n.t('pages.other.keywords', name: 'other')}']"
  end

end
