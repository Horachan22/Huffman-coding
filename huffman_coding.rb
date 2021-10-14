'''
===================================================================
Project Name  : 情報理論 ハフマン符号化
File Name     : huffman_coding.py
Encoding      : UTF-8
Creation Date : 2/1/2021
Copyright (c) 2021 Yuma Horaguchi All rights reserved.
===================================================================
'''

#ノードのclass
class Node
	attr_accessor :name, :value, :code, :prev, :left, :right
	#初期化メソッド
	def initialize(name = 'None', value = 0, code = [], prev = nil, left = nil, right = nil)
		@name = name
		@value = value
		@code = code
		@prev = prev
		@left = left
		@right = right
	end
	#情報源の要素かどうかを判別する関数
	def judge_symbol()
		if @left == nil && @right == nil
			true
		else
			false
		end
	end
	#木の先頭かどうかを判別する関数
	def judge_top()
		if @prev == nil
			true
		else
			false
		end
	end
	#そのノードのコードを表示する関数
	def print_code()
		for i in 0 .. code.size do
			print(code[code.size - i])
		end
	end
	#コード割り当ての関数
	def huffman_coding(num)
		if judge_symbol == false
			left.code.push num
			right.code.push num
			left.huffman_coding(num)
			right.huffman_coding(num)
		end
	end
	#ルートから分岐しているノードに値を割り振る関数
	def huffman_root()
		if judge_top == true
			left.code.push '0'
			left.huffman_coding('0')
			right.code.push '1'
			right.huffman_coding('1')
		end
	end
	#ハフマン符号を表示する関数
	def print_huffman()
		if judge_symbol == true
			if code.size != 0
				printf("%s     ", name)
				print_code()
				printf("\n")
			end
		end
		if left
			left.print_huffman()
		end
		if right
			right.print_huffman()
		end
	end
end
#ノードの合体を行う関数
def connect_nodes(node_small, node_big)
	new_name = node_small.name  + node_big.name
	new_node = Node.new(new_name ,node_small.value + node_big.value)
	node_small.prev = new_node
	node_big.prev = new_node
	new_node.left = node_small
	new_node.right = node_big
	new_node.huffman_root()
	return new_node
end
#情報源の初期値入力を行う関数する関数
def create_source()
	source = []
	print('情報源の要素数を選び数字で入力してください:')
	n = gets.to_i
	for i in 0 .. (n - 1) do
		print('情報の記号を入力してください(A,B,C...の順)：')
		char = gets.chomp
		print('情報の値を入力してください：')
		val = gets.to_f
		source.push Node.new(char, val)
	end
	return source
end
#情報源を値の小さい順に並び替える
def sort (source)
	for i in 0 .. (source.size - 1)
		for j in i .. (source.size - 1)
			if source[j].value < source[i].value
				temp = source[j]
				source[j] = source[i]
				source[i] = temp
			end
		end
	end
	return source
end
#情報源にある中で最小の値と二番目に小さい値を返す関数
def get_min(source)
	temp = sort(source)
	min = temp[0]
	second_min = temp[1]
	return min, second_min
end
#ノードができた時、新たな比較を行えるような配列を生成する関数
def make_new_source(source, node)
	source = sort(source)
	new_source = []
	for i in 2 .. (source.size - 1) do
		new_source.push source[i]
	end
	new_source.push node
	return new_source
end
#木の作成
def make_tree(source)
	source = make_new_source(source, connect_nodes(get_min(source)[0], get_min(source)[1]))
	while source.size > 1 do
		source = make_tree(source)
	end
	return source
end
#main関数
def main()
	source = create_source()
	source = make_tree(source)
	puts('***結 果***')
	source[0].print_huffman()
end

if __FILE__ == $0
	main()
end
