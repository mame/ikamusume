# coding: utf-8

require "prettyprint"

# Proc と String を侵略してやるでゲソ
class Proc
  alias <= call
end

class String
  def <=(x)
    display
    x
  end
end

# 侵略!コンビネータ (S) じゃなイカ？
def shinryaku!
  proc {|x| proc {|y| proc {|z| x <= z <= (y <= z) } } }
end

# ゲソコンビネータ (K) じゃなイカ？
def geso
  proc {|x| proc {|y| x } }
end

# イカ娘!コンビネータ (I) じゃなイカ？
def ika?
  proc {|x| x }
end

[ [:shinryaku!, :"侵略!", :"侵略！"],
  [:geso, :geso!, :"ゲソ", :"ゲソ!", :"ゲソ！"],
  [:ika?, :ikamusume!, :"イカ?", :"イカ？", :"イカ娘!", :"イカ娘！"],
].each do |m, *ms|
  ms.each do |m2|
    Kernel.module_eval { alias_method(m2, m) }
  end
end

# Unlambda も侵略してやるでゲソ
def unlambda_to_ikamusume!(src, keywords = [["侵略!", 5], ["ゲソ", 4], ["イカ娘!", 7]])
  PrettyPrint.format("", 0) do |pp|
    translate = proc do |need_paren|
      ch = src.slice!(0, 1)
      case ch
      when "`"
        if need_paren
          pp.group(2, "(", ")") do
            translate[false]
            pp.text " <="
            pp.breakable
            translate[true]
          end
        else
          translate[false]
          pp.text " <="
          pp.breakable
          translate[true]
        end
      when "s" then pp.text *keywords[0]
      when "k" then pp.text *keywords[1]
      when "i" then pp.text *keywords[2]
      when "." then pp.text src.slice!(0, 1).dump
      when "r" then pp.text '"\n"'
      when "#" then src.slice!(/.*/); translate[need_paren]
      when /\A\s\z/ then translate[need_paren]
      when nil then raise "unexpected termination"
      else raise "unimplemented instruction: %p" % ch
      end
    end
    translate[false]
  end
end
