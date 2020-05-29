ActionView::Helpers::JavaScriptHelper::JS_ESCAPE_MAP.merge!(
  # "`" を "\\`"に,"$" を "\\$"に変換する
{
    "`" => "\\`",
    "$" => "\\$"
  }
)