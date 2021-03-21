extends Node
var amountToBet=0
var money=5000
var betValue=0
var baseProbabilityOfWinning=0.0
var actualProbabilityOfWinning=0.0
var numberOfWins=0
var numberOfLosses=0
var numberOfMatches=0
var totalNumberOfMatches=10

var debug2d
var pos2dYouWin
var pos2dYouLose
var pos2dCircleFx
const strYouWin=preload("res://scenes/strYouWin.tscn")
const strYouLose=preload("res://scenes/strYouLose.tscn")
const circleFx=preload("res://scenes/circleFx.tscn")
const selectSfx=preload("res://scenes/selectSfx.tscn")
signal gameOver

func _ready():
	# A message to you, reader of this source code:
	# The shown probability is different from the actual probability.
	# I believe it makes the game more interesting?
	# I mean, if the player keeps loosing, making it easier for
	# them to win helps a bit. Also, if they keep winning,
	# making the odds against them also could make things
	# more interesting.
	set_process(true)
func _process(delta):
	if global.money!=0:
		self.betValue=self.amountToBet*self.money
		self.baseProbabilityOfWinning=50+clamp(50*(1-global.betValue/global.money),0,49.99)
		self.actualProbabilityOfWinning=self.baseProbabilityOfWinning-15*(numberOfWins/totalNumberOfMatches)+25*(numberOfLosses/totalNumberOfMatches)
	else:
		emit_signal("gameOver")
		self.betValue=self.amountToBet*self.money
		set_process(false)

func resetGame():
	self.numberOfLosses=0
	self.numberOfWins=0
	self.numberOfMatches=0
	self.amountToBet=0
	self.money=5000
	self.betValue=0
	add_child(selectSfx.instance())
	set_process(true)
	get_tree().reload_current_scene()

func handleBet():
	if totalNumberOfMatches-numberOfMatches>0:
		randomize()
		print_debug('Handling bet...')
		print_debug('Actual chance of winning:')
		print_debug(actualProbabilityOfWinning)
		var k=circleFx.instance()
		k.global_position=pos2dCircleFx.global_position
		self.debug2d.add_child(k)
		add_child(selectSfx.instance())
		if randf()<actualProbabilityOfWinning/100.0:
			print_debug('You won!')
			self.money+=self.betValue
			self.numberOfWins+=1
			self.numberOfMatches+=1
			var i=strYouWin.instance()
			i.rect_global_position=self.pos2dYouWin.global_position
			self.debug2d.add_child(i)
		else:
			print_debug('You lost...')
			self.money-=self.betValue
			self.numberOfLosses+=1
			self.numberOfMatches+=1
			var i=strYouLose.instance()
			i.rect_global_position=self.pos2dYouLose.global_position
			self.debug2d.add_child(i)
	if numberOfMatches-totalNumberOfMatches==0:
		emit_signal("gameOver")
		
