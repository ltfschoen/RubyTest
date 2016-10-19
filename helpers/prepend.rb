class String
  def >> (s)
    s.prepend(self)
  end
end