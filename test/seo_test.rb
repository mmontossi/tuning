require 'test_helper'

class SeoTest < ActionView::TestCase

  test 'keywords and descriptions' do
    render template: 'pages/index', layout: 'layouts/application'
    assert_select 'title', I18n.t('pages.index.title')
    assert_select %Q{meta[content="#{I18n.t('pages.index.description')}"]}
    assert_select %Q{meta[content="#{I18n.t('pages.index.keywords')}"]}

    render template: 'pages/variable', layout: 'layouts/application'
    assert_select 'title', I18n.t('pages.variable.title', name: 'other')
    assert_select %Q{meta[content="#{I18n.t('pages.variable.description', name: 'other')}"]}
    assert_select %Q{meta[content="#{I18n.t('pages.variable.keywords', name: 'other')}"]}

    render template: 'pages/empty', layout: 'layouts/application'
    assert_select 'title', ''
    assert_select %Q{meta[content=""]}, 2

    render template: 'pages/defined', layout: 'layouts/application'
    assert_select 'title', 'title'
    assert_select %Q{meta[content="description"]}
    assert_select %Q{meta[content="keywords"]}
  end

end
