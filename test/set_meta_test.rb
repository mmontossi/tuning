require 'test_helper'

class SetMetaTest < ActionView::TestCase

  test "should populate meta using the path of the template as key" do
    render template: 'pages/index', layout: 'layouts/application'
    assert_select 'title', I18n.t('pages.index.meta.title')
    assert_select "meta[content='#{I18n.t('pages.index.meta.description')}']"
    assert_select "meta[content='#{I18n.t('pages.index.meta.keywords')}']"
 
    render template: 'pages/other', layout: 'layouts/application'
    assert_select 'title', I18n.t('pages.other.meta.title', name: 'other')
    assert_select "meta[content='#{I18n.t('pages.other.meta.description', name: 'other')}']"
    assert_select "meta[content='#{I18n.t('pages.other.meta.keywords', name: 'other')}']"
  end

end
