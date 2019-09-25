class Minimax

  def self.best_move(tree)
    return nil if tree.empty?
    tree.each do |node|
      node[:score] += score_of(node[:children])
    end
    result = min_or_max(tree, true)
    result[:position]
  end

  private

  def self.score_of(children, maximising = false)
    return 0 if children.empty?

    child_score = children.map do |child|
      score_of(child[:children], !maximising)
    end.sum

   child_score + min_or_max(children, maximising)[:score] - 1
  end

  def self.min_or_max(children, maximising)
    if maximising
      children.max_by { |c| c[:score] }
    else
      children.min_by { |c| c[:score] }
    end
  end


end

