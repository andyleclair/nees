defprotocol Nees.Shape do
  @doc "Produce a set of drawing instructions for a shape"
  @spec draw(Nees.Shape) :: Nees.Command.t()
  def draw(shape)
end
