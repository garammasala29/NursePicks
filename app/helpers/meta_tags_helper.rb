# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength
    {
      site: 'NursePicks',
      title: 'NursePicks',
      reverse: true,
      separator: '|',
      charset: 'utf-8',
      description: '看護師さんのための情報収集サイト。看護に関する価値ある記事を探したり、おすすめの記事を投稿しよう',
      keywords: '看護師,情報収集,看護記事,看護研究',
      viewport: 'width=device-width, initial-scale=1.0',
      icon: [
        { href: image_url('favicon.png') }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: 'https://nursepicks.herokuapp.com/',
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        title: :title,
        card: 'summary_large_image',
        site: '@garammasala29',
        description: :description,
        image: image_url('ogp.png'),
        domain: 'https://nursepicks.herokuapp.com/'
      }
    }
  end
end
