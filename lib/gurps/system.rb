require 'gurps/character'
require 'gurps/skill'
require 'gurps/statblocks/renderer'

# Inject rendering function to character.
class GURPS::Character
  include GURPS::Statblocks::Renderer
end



