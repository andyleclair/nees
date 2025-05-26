defprotocol Nees.Shape do
  @doc "Produce a list of drawing instructions for a shape"
  def draw(shape)
end
