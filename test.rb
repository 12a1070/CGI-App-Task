# ライブラリ「webrick」を呼び出しています
require 'webrick'
# WEBrick::HTTPServer.newでWebrickのインスタンスを作成し、serverという名前のローカル変数に入れます。
server = WEBrick::HTTPServer.new({
# このWebアプリケーションのドメインの設定（ここに書き込まれた記述が、作成するWebアプリケーションのドメインになる）
  :DocumentRoot => '.',
# このプログラムを実行（翻訳）できるプログラム（Rubyのこと）本体の居場所を指定する記述。
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
# このWebアプリケーションの情報の出入り口を表す設定。
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
# Webサーバを起動した状態で、（DocumentRootの値）/testというURLを送信すると、同じディレクトリ階層にあるtest.html.erbファイルを表示する
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.start
