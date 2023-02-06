class Gossip
  attr_accessor :author, :content
  
  def initialize(author, content)
    @content = content
    @author = author
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@content, @author]
    end
  end

  def self.all
    all_gossips = Array.new
    csv = CSV.read("db/gossip.csv", :headers=>true)
    csv.each do |row|
      all_gossips << Gossip.new(row['author'], row['content'])
    end
    return all_gossips
  end
end

