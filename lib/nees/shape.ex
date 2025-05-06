defprotocol Nees.Shape do
  @doc "Produce a set of drawing instructions for a shape"
  def draw(shape)
end
