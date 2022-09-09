# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength
    {
      reverse: true,
      charset: 'utf-8',
      description: '看護師向けの価値ある情報サイト。価値ある看護記事を探したり、おすすめの看護記事を投稿しよう',
      keywords: '看護師,情報収集,看護記事,看護研究',
      viewport: 'width=device-width, initial-scale=1.0',
      icon: [
        { href: image_url('favicon.png') }
      ],
      og: {
        site_name: 'NursePicks',
        description: :description,
        type: 'website',
        url: 'https://www.nursepicks.jp/',
        image: 'https://www.nursepicks.jp/ogp/ogp.png',
        locale: 'ja_JP'
      },
      twitter: {
        title: 'NursePicks',
        card: 'summary_large_image',
        site: '@garammasala29',
        description: :description,
        image: 'https://www.nursepicks.jp/ogp/ogp.png',
        domain: 'https://www.nursepicks.jp/'
      }
    }
  end
end
