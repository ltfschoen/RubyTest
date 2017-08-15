class Game
  attr_accessor :name, :players, :levels
  def initialize(name, players, levels)
    @name = name
    @players = players
    @levels = levels
    @current_level = 0
    @current_player = 0
  end

  def run
    user_input = ""
    while user_input
      @players.each_with_index do |player, index|
        @current_player = index
        show_question
        user_input = gets.chomp
        exit(0) if user_input == "q"
        correct_answer_for_input?(user_input)
        show_progress
        increase_level if change_level?
      end
      break if @current_level > (@levels.length - 1)
    end
    show_winner
  end

  def show_question
    puts "\nplayer name: #{@players[@current_player].name}, level name: #{@levels[@current_level].id}\n\n"
    puts "question: #{@levels[@current_level].challenge[:question]}. press 'q' to exit"
    print "\t> "
  end

  def correct_answer_for_input?(input)
    answer = @levels[@current_level].challenge[:answer]
    if input == answer
      @players[@current_player].scores << "1"
      puts "correct!"
    else
      @players[@current_player].scores << "0"
      puts "incorrect, answer is #{answer}"
    end
  end

  def show_progress
    puts "\nprogress update:"
    @players.each do |player|
      puts "\tplayer name: #{player.name}, level: #{@current_level + 1}, score: #{player.total_score} / #{max_total_score}"
    end
  end

  def max_total_score
    @levels.length
  end

  def compare_scores(current_player_score, best_score)
    current_player_score <=> best_score
  end

  def show_winner
    winner = nil
    best_score = 0
    @players.each do |player|
      current_player_score = player.total_score
      if (compare_scores(current_player_score, best_score) == 1)
        best_score = current_player_score
        winner = player
      end
    end
    if (best_score == 0)
      puts "\nno winner"
    else
      puts "\nwinner is #{winner.name} with score #{best_score}"
    end
  end

  def change_level?
    true if (@current_player % 2 == 1)
  end

  def increase_level
    @current_level = @current_level + 1
  end

end

class Level
  attr_accessor :id, :challenge
  def initialize(id, challenge)
    @id = id
    @challenge = {
      question: challenge[:question],
      answer: challenge[:answer]
    }
  end
end

class Player
  attr_accessor :name, :scores, :level_id
  def initialize(name, level_id)
    @name = name
    @scores = []
    @level_id = level_id
  end

  def total_score
    @scores.join("").count("1")
  end
end

challenge1 = { question: "four squared?", answer: "16" }
challenge2 = { question: "square root of 16?", answer: "4" }
challenge3 = { question: "modulus 16 % 5?", answer: "1" }
level1 = Level.new(1, challenge1)
level2 = Level.new(2, challenge2)
level3 = Level.new(3, challenge3)
player1 = Player.new("p1", 1)
player2 = Player.new("p2", 1)
players = [player1, player2]
levels = [level1, level2, level3]
game1 = Game.new("cs", players, levels)
game1.run
