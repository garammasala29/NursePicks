module ApplicationHelper
  def default_meta_tags
    {
      site: 'NursePicks',
      title: 'NursePicks',
      reverse: true,
      separator: '|',
      charset: 'utf-8',
      description: '看護師さん向けの情報サイト',
      keywords: 'キーワード',
      viewport: 'width=device-width, initial-scale=1.0',
      icon: [
        { href: image_url('favicon.png') },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: 'https://nursepicks.herokuapp.com/',
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        title: :title,
        card: 'summary_large_image',
        site: '@garammasala29',
        description: :description,
        image: image_url('ogp.png')
        domain: 'https://nursepicks.herokuapp.com/'
      }
    }
  end
end
