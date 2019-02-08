class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  GENRES = { 'アクション' => 28, '冒険' => 12, 'コメディー' => 35, 'アニメーション' => 16, '犯罪' => 80, 'SF' => 878, 
             'ミステリー' => 9648, 'ファンタシー' => 14, 'ロマンス' => 10749, 'ホラー' => 27, '音楽' => 10402, 'ファミリー' => 10751, 
             'ドラマ' => 18, '歴史' => 36, '戦争' => 10752, 'スリラー' => 53, 'ドキュメンタリー' => 99, '西部劇' => 37 }

  # confirm a logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_path
    end
  end
end
