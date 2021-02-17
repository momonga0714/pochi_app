json.array!(@mains) do |m|
  json.extract! m, :id, :main_name
  json.start m.start_date
  json.end m.end_date
  json.url m_url(m, format: :html)
end