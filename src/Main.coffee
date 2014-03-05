#= require Level
#= require Splash

DwarfSquad = window.DwarfSquad

SceneManager = DwarfSquad.SceneManager
Level = DwarfSquad.Level
Splash = DwarfSquad.Splash

class Main extends Phaser.State
  constructor:(@parent='')->

  run:(debug = false)->
    mode = if debug then Phaser.CANVAS else Phaser.AUTO
    new Phaser.Game(896, 504, mode, @parent, this)

  destroy:->
    destroy(@text)
    destroy(@graphics)

  preload:()=>
    @game.stage.disableVisibilityChange=true

    @game.stage.scale.pageAlignHorizontally = true
    @game.stage.scale.pageAlignVertically = false
    @game.stage.scale.setShowAll()
    @game.stage.scale.refresh()

    @game.stage.scale.enterLandscape.add =>
      @game.stage.scale.setShowAll()
      @game.stage.scale.refresh()

    @game.stage.scale.enterPortrait.add =>
      @game.stage.scale.setShowAll()
      @game.stage.scale.refresh()

    message = "=== D W A R F S Q U A D ===\nis\nLOADING"
    style =
      font: "30px Courier"
      fill: "#00ff44"
      align: "center"
    @text = @game.add.text(@game.world.centerX, @game.world.centerY, message, style)
    @text.anchor.setTo(0.5, 0.5)
    @graphics = @game.add.graphics(0, 0)

    @graphics.lineStyle(1, 0x5588cc, 1)
    @graphics.drawRect(199, 339, 502, 22)

    @game.load.onLoadComplete.addOnce(@ready)

    @game.state.add('splash', new Splash(), false)
    @game.state.add('level', new Level(), false)
    @game.load.image('logo', 'images/logo.png')
    @game.load.image('labs', 'images/labs.png')
    @game.load.spritesheet('dwarf1', 'images/dwarf_01.png', 32, 32)
    @game.load.spritesheet('dwarf2', 'images/dwarf_04.png', 32, 32)
    @game.load.spritesheet('dwarf3', 'images/dwarf_03.png', 32, 32)
    @game.load.spritesheet('dwarf4', 'images/dwarf_02.png', 32, 32)
    @game.load.spritesheet('skeleton', 'images/skel.png', 32, 32)
    @game.load.spritesheet('sheep', 'images/sheep.png', 32, 32)
    @game.load.spritesheet('arrow', 'images/arrows.png', 16, 16)
    @game.load.spritesheet('objects', 'images/objects.png', 32, 32)
    @game.load.image('key',   'images/key.png')
    @game.load.spritesheet('world', 'images/world.png', 32, 32)
    @game.load.image('boulder', 'images/boulder.png')
    @game.load.tilemap('level01', 'maps/level01.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level02', 'maps/level02.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level03', 'maps/level03.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('treasure_room', 'maps/treasure_room.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level_skeletons', 'maps/level_skeletons.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('intro', 'maps/intro.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.audio('splash', 'songs/DwarfMusic01.mp3');
    @game.load.audio('pain', 'sounds/pain.wav');
    @game.load.audio('crazy', 'sounds/CrazyTime.mp3');
    @game.load.audio('collect', 'sounds/Collect.mp3');
    @game.load.audio('baa1', 'sounds/SheepBaa1.mp3')
    @game.load.audio('baa2', 'sounds/SheepBaa2.mp3')
    @game.load.audio('baa3', 'sounds/SheepBaa3.mp3')
    @game.load.audio('button1', 'sounds/Button1.mp3');
    @game.load.audio('button2', 'sounds/Button2.mp3');
    @game.load.audio('bones', 'sounds/SkeletonBones.mp3')
    @game.load.audio('coin1', 'sounds/Coin1.mp3');
    @game.load.audio('coin2', 'sounds/Coin2.mp3');
    @game.load.audio('coin3', 'sounds/Coin3.mp3');
    @game.load.audio('coin4', 'sounds/Coin4.mp3');
    @game.load.audio('burp', 'sounds/Burp.mp3');

  loadRender:->
    @graphics.beginFill(0x00ff44)
    @graphics.drawRect(200, 340, 5 * @game.load.progress, 20)
    @graphics.endFill()

  render:->
    @graphics.clear()
    @loadRender() unless @game.load.hasLoaded

  ready:=>
    @text.alpha = 0.0
    @music = @game.add.audio('splash');
    @music.play('', 0, 4, true)
    @game.physics.gravity.y = 0
    @startGame()

  startGame:=>
    @game.state.start('splash')

DwarfSquad.Main = Main
