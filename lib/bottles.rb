class Bottles
    @@total = 99

    def self.total
        @@total
    end

    def song
        self.verses(@@total, 0)
    end

    def verses(high, low)
        high.downto(low).map { |bottle| self.verse(bottle) }.join("\n")
    end

    def verse(number)
        Verse.number(number).to_s
    end
end

class Verse
    def self.number(number)
        case number
        when 0
            ZeroBottleVerse.new
        when 1
            OneBottleVerse.new
        when 6
            OneSixPackVerse.new
        else
            ManyBottlesVerse.new(number)
        end
    end

    def to_s()
        "#{self.container().capitalize} of beer on the wall, #{self.container()} of beer.\n" \
        "#{self.take_bottle()}, #{self.next().container()} of beer on the wall.\n"
    end
end

class ZeroBottleVerse  < Verse
    def container()
        'no more bottles'
    end

    def take_bottle()
        'Go to the store and buy some more'
    end

    def next()
        Verse.number(Bottles.total)
    end
end

class PassAroundVerse < Verse
    attr_reader :container

    def take_bottle()
        "Take #{@bottle_article} down and pass it around"
    end

    def next()
        Verse.number(@number_of_bottles - 1)
    end
end

class ManyBottlesVerse < PassAroundVerse
    def initialize(number_of_bottles)
        @number_of_bottles = number_of_bottles
        @container = "#{number_of_bottles} bottles"
        @bottle_article = 'one'
    end
end

class OneBottleVerse < PassAroundVerse
    def initialize()
        @number_of_bottles = 1
        @container = '1 bottle'
        @bottle_article = 'it'
    end
end

class OneSixPackVerse < PassAroundVerse
    def initialize()
        @number_of_bottles = 6
        @container = '1 six-pack'
        @bottle_article = 'one'
    end
end