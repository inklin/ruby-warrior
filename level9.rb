class Player

  def play_turn(warrior)
    @warrior = warrior
    @health ||= 20
    @space = @warrior.feel
    do_something()
    @health = warrior.health
  end
  
  def do_something()
    min_health = 10
    return turn_around if @space.wall?
    return rescue_captive if @space.captive?
    return attack if @space.enemy?
    return shoot_arrow if clear_shot && !under_attack
    return rest if @warrior.health < min_health && !under_attack
    return walk
  end
  
  def walk()
    @warrior.walk!
  end
  
  def rest()
    @warrior.rest!
  end
  
  def shoot_arrow()
    @warrior.shoot!
  end
  
  def turn_around()
    @warrior.pivot!
  end
  
  def attack()
    @warrior.attack!
  end
  
  def rescue_captive()
    @warrior.rescue!
  end
  
  def under_attack()
    return @warrior.health < @health
  end
  
  def clear_shot()
    max_distance = 4
    look_ahead = @warrior.look
    enemy_distance = look_ahead.index { |space| space.enemy? } || max_distance
    captive_distance = look_ahead.index { |space| space.captive? } || max_distance
    return enemy_distance < captive_distance
  end
end