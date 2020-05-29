module ActionView::Helpers::JavaScriptHelper
  # escape_javascriptをold_ejで呼び出せるように変更する
  alias :old_ej :escape_javascript
  # jをold_jで呼び出せるように変更する
  alias :old_j :j

  def escape_javascript(javascript)
  # 引数のjavascriiptを文字に変換する
  javascript = javascript.to_s
# もし、javascriptが空なら空白を返す
    if javascript.empty?
      result = ""
    # そうでなければ、正規表現にマッチした文字をJS_ESCAPE_MAPで定義したマップに変換する
    else
      result = javascript.gsub(/(\\|<\/|\r\n|\342\200\250|\342\200\251|[\n\r"']|[`]|[$])/u, JS_ESCAPE_MAP)
    end
    javascript.html_safe? ? result.html_safe : result
  end
# escape_javascriptをjで呼び出せるように変更する
  alias :j :escape_javascript
end