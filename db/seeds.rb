# frozen_string_literal: true

if Rails.env.development?
  (1..30).each do |i|
    User.create(name: "name#{i}", uid: SecureRandom.hex(10), provider: 'twitter', icon_url: 'icon_user_m.png')
  end

  Post.create(
    title: 'Example Domain', url: 'https://www.example.com', user_id: 1, site_name: '', image_url: 'logo_picks.png'
  )

  Post.create(
    title: '心電図モニターの不適切なアラームに関する現状調査について',
    url: 'https://www.jstage.jst.go.jp/article/jjrm/64/2/64_172/_article/-char/ja/',
    site_name: 'J-STAGE',
    image_url: 'https://www.jstage.jst.go.jp/html/images/common/SNS/J-STAGE_logo_sns.png',
    user_id: 1,
    created_at: Time.zone.now.yesterday,
    tag_list: %w[心電図 論文 循環器]
  )

  Post.create(
    title: '『人工呼吸ケアのすべてがわかる』記事一覧 | 看護roo![カンゴルー]',
    url: 'https://www.kango-roo.com/learning/3579/',
    site_name: '看護roo!',
    image_url: 'https://img.kango-roo.com/sn/thumbnail/phpEUoKA520161226013859.jpg',
    user_id: 2,
    created_at: Time.zone.now.ago(3.days),
    tag_list: ['人工呼吸器']
  )
  Post.create(
    title: 'RASS（Richmond Agitation- Sedation Scale） | ナース専科',
    url: 'https://knowledge.nurse-senka.jp/500283',
    site_name: 'ナース専科',
    image_url: 'https://cdn-knowledge-assets.nurse-senka.jp/wp-content/uploads/2021/11/24100339/scales.jpg',
    user_id: 3,
    created_at: Time.zone.now.ago(10.minutes),
    tag_list: ['スケール']
  )

  (1..30).each do |i|
    Like.create(user_id: i.to_s, post_id: 3)
    Comment.create(content: 'いい記事ですね', user_id: i.to_s, post_id: 1)
  end

  Like.create(user_id: 1, post_id: 1)
end
