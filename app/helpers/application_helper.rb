module ApplicationHelper
  # 字符串取前length 长度的值
  def deal_string(str, length)
    str.length > length ? "#{str[0...length]}...": str
  end
end
