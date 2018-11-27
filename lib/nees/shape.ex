defprotocol Ness.Shape do
  @doc "Produce a set of drawing instructions for a shape"
  @spec draw(Ness.Shape) :: Ness.Command.t()
  def draw(shape)
end
