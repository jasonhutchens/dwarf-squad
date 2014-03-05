#= require Entity
#= require Carryable

DwarfSquad = window.DwarfSquad

Entity = DwarfSquad.Entity
Carryable = DwarfSquad.Carryable

class Key extends Carryable
  create_sprite: =>
    @sprite = @game.add.sprite(0, 0, 'key')

DwarfSquad.Key = Key
