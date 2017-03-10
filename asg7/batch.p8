pico-8 cartridge // http://www.pico-8.com
version 10
__lua__
cls()

--modified from batch-example
assets={
	{filename='bird.png', description='bird'},
	{filename='doge.png', description='dog'},
	{filename='nebula.png', description='nebula'},
}

output_filename = "generated.lua"

function write(text,overwrite)
	printh(text,output_filename,overwrite)
end

--from zrax.p8
function xor_encode(bytes)
	assert(type(bytes)=="table")
	local result = {}
	local state = 0
	for b in all(bytes) do
		add(result, bxor(state, b))
		state = b
	end
	return result
end

function z_encode(bytes)
	assert(type(bytes)=="table")
	local result = {}
	local i = 1
	while i <= #bytes do
		if bytes[i] > 0 then
			add(result, bytes[i])
			i += 1
		else -- bytes[i]==0
			add(result, 0)
			local count=0
			while i <= #bytes and bytes[i]==0 and count < 0x7fff do
				i += 1
				count += 1
			end
			if count > 256 then
				add(result, 0)
				add(result, flr(count/256))
				add(result, flr(count%256))
			else
				add(result, count)
			end
		end
	end -- while
	return result
end

function zrax_encode(bytes)
	assert(type(bytes)=="table")
	return z_encode(xor_encode(bytes))
end

function mem_to_bytes(addr, num)
	local bytes = {}
	for i = 1,num do
		add(bytes,peek(addr+i-1))
	end
	return bytes
end
		
function bytes_to_hex(bytes)
	assert(type(bytes)=="table")
	if not _int2hex then
		local symbols = "0123456789abcdef"
		_int2hex = {}
		for i=1,#symbols do
			local ch = sub(symbols,i,i)
			_int2hex[i-1] = ch
		end
	end
	local hex = ""
	for b in all(bytes) do
		assert(b >= 0 and b <= 255)
		local hi = _int2hex[flr(b/16)]
		local lo = _int2hex[flr(b%16)]
		hex = hex..(hi..lo)
	end
	return hex
end

write("-- begin generated code", true) -- create the file
write("compressed_assets = {")


for f in all(assets) do

	print("processing "..f.filename) -- status to pico screen
	
	import(f.filename) -- update sprites in cart
	reload(0x0,0x0, 0x2000) -- update ram with new sprites in cart
	local byte = mem_to_bytes(0x0,0x1000) -- inspect sprite ram
	byte = zrax_encode(byte)
	hex=bytes_to_hex(byte)
	print(byte)
	local l = "\t'"..f.filename.."' = '"..hex.."',"
	write(l)
			
end

write("}")
write("-- end generated code")
print("done")



__gfx__
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
777777777777777777766666666d6777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777776d51000000000d77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777777777765100111115111000d777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777777777d000001151551151000677777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777750100111100511551100067777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777500000100000155111110005777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777775000000000000155511110000177777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
777777777d0000000000000515551111000017777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777710000000000000511555510000001777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777600000000000010151155151111000577777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
777777760000000000000101100100155100000d7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7776d510000000000000000005ddddd66d6550007777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77d5dd66f50000000000005d6777777777777d005777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7d05d66f76d5115d5d66ff7777777777777777500677777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77d10000155501f7fff777ffff777777777777500177777777777777777777777777777777777777777777777777777777777777777777777777777777777777
777776d50010000df7fff7fff7777777777776511057777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777760000000d77f77fff777777777776111110d777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777775000000067777fff7ff77777ffd00001154d77777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777760000000167f777ffffff77fd50000015445d7777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777776000000005f7777f666ff76100000005944554777777777777777777777777777777777777777777777777777777777777777777777777777777777
777777777710000000016f77ff6ff6d1000000004444450477777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777777100000000055d66666d5000000005444555550d7777777777777777777777777777777777777777777777777777777777777777777777777777777
777777777750000000000015d551000000005444444445555d777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777777d000000000000100000000000044454445444550477777777777777777777777777777777777777777777777777777777777777777777777777777
77777777776000000000000000000000555554444445544555547777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777100000000010000545555555555445444555454554777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777100000000001544994451555555554444455455445477777777777777777777777777777777777777777777777777777777777777777777777777
77777777777100000000054999444551555555555554445445444547777777777777777777777777777777777777777777777777777777777777777777777777
7777777777750000000599a949449455555555555555544444544454777777777777777777777777777777777777777777777777777777777777777777777777
7777777777760000004a999944449955555554554554454444545545577777777777777777777777777777777777777777777777777777777777777777777777
7777777777770000049949944449994d5d55554444555544444445445d7777777777777777777777777777777777777777777777777777777777777777777777
77777777777700005449949944499994ddd555444445554444544444556777777777777777777777777777777777777777777777777777777777777777777777
77777777777700055544444994449994455555544444445545554445455777777777777777777777777777777777777777777777777777777777777777777777
777777777777000554444444449949994555d5555444445545555545544d77777777777777777777777777777777777777777777777777777777777777777777
777777777777000055444444444994994555d5d55544444544544544554567777777777777777777777777777777777777777777777777777777777777777777
77777777777750000554444444449449ad555d55d544445444454444555557777777777777777777777777777777777777777777777777777777777777777777
777777777777505000544444444449444455dd5dddd544554444554444455d777777777777777777777777777777777777777777777777777777777777777777
777777777777505000544444444444945455ddddd555554d55444554454d55677777777777777777777777777777777777777777777777777777777777777777
777777777777d050000544444444449a45015ddd5555d55dd55d5d55dd44d5567777777777777777777777777777777777777777777777777777777777777777
77777777777760500005554444444444af501dddd5dd5d555dddd6f666f666d57777777777777777777777777777777777777777777777777777777777777777
7777777777776055000554444444444449dd55dd5dddddd55d6fff7777777f655677777777777777777777777777777777777777777777777777777777777777
777777777777755500005444444444445544dd5dddddddd66667777777766fd55557777777777777777777777777777777777777777777777777777777777777
7777777777777d05500054444444444444505ddd55dddddf7777f776dddddd6d5d55777777777777777777777777777777777777777777777777777777777777
77777777777776555500054444444444444500555555d6f77777f6d55ddd6d666554d77777777777777777777777777777777777777777777777777777777777
77777777777777d5550000544444444945545001555556ff7ff6ddd5ddddd6dd6f51467777777777777777777777777777777777777777777777777777777777
7777777777777765550000054444444494455550055555ddd55555ddd5ddddddd67615f777777777777777777777777777777777777777777777777777777777
777777777777776555000005544444444a945055515005555555dd5dddd5ddddd667f51f77777777777777777777777777777777777777777777777777777777
777777777777777d550000005544444949aa9455454400055555ddd5ddddd55ddd6d6750d7777777777777777777777777777777777777777777777777777777
7777777777777776555000005544494499a4aa4444aaa4101555dddd5dddddd5dddd667d0d777777777777777777777777777777777777777777777777777777
7777777777777777455000000544444999994aaaafaaaff4551115dddddddddddddd6667f0d77777777777777777777777777777777777777777777777777777
77777777777777776555000000544444999aaaaaafaaaaffff455005ddddddddddd5d6667f567777777777777777777777777777777777777777777777777777
777777777777777775555000000444444999aaaaaaaaaaafffffa95005dddddd5ddd5d6667f67777777777777777777777777777777777777777777777777777
777777777777777776050000000544444999999a99aaaaaaafffaaa95015ddddd5ddd55d667f6777777777777777777777777777777777777777777777777777
777777777777777777d055000005554444499449a99aaaaaaafffaaaa40015ddd555d555d666f677777777777777777777777777777777777777777777777777
7777777777777777777505000000055444449999aaa9aaaaaaafffaaaaa40005ddd555d555666667777777777777777777777777777777777777777777777777
7777777777777777777600000000005444449999aaaaaaaaaaaaaaaaaaaa450005ddd555555d66d7777777777777777777777777777777777777777777777777
7777777777777777777760000000000544449949aaaaaaaaaaaaaaaaaa44a4510015ddd55555d66d777777777777777777777777777777777777777777777777
777777777777777777777d0000000000544444949aaaaaaaaaaaaaaa4aa4444551005ddd55555d66677777777777777777777777777777777777777777777777
7777777777777777777777505000000054444494449aaaaaaaaaaaaaa44a44444500055ddd55555dd77777777777777777777777777777777777777777777777
77777777777777777777777100000000054444444449aaaaaaaaaaaaaa944444445000055dd555555d7777777777777777777777777777777777777777777777
7777777777777777777777770000000000554444444499a9aaaaaaaaaaa944444555100005ddd555516777777777777777777777777777777777777777777777
77777777777777777777777760005000050054444444499999aaa99a99999444445510000005dd55550677777777777777777777777777777777777777777777
7777777777777777777777777d0005000505554444444499999aaaaa9999444444455000000005dd555d77777777777777777777777777777777777777777777
77777777777777777777777777d000000000055544444449999aaaa44499444444dddd5510000005dd5577777777777777777777777777777777777777777777
777777777777777777777777777d000000000055544444449999aa99a4444444444dddddd510000005d557777777777777777777777777777777777777777777
777777777777777777777777777760000000550555444444499999aa9a444444444ddddddddd5100001d55777777777777777777777777777777777777777777
77777777777777777777777777777600000005505555544449aaa9aa99949af4d454d66666d5dd55000055577777777777777777777777777777777777777777
77777777777777777777777777777771000000555555554444449aaaaaaaaafffd55ddd6ff76d5ddd500000d7777777777777777777777777777777777777777
777777777777777777777777777777775000000005555554444444aaaaffffffffdd6ddd6f776d55d6d51000d777777777777777777777777777777777777777
7777777777777777777777777777777776000000005555555444444aafffffffff6dddd66ff77fd105ddd5100d77777777777777777777777777777777777777
77777777777777777777777777777777777500000000005554554444afffffffff6dd44d6fff77765005d5d510d7777777777777777777777777777777777777
777777777777777777777777777777777777750000000000005554444add6ff6ff6d77d4d66fff777d005dd5d50d777777777777777777777777777777777777
77777777777777777777777777777777777777610000000005ddd444df6ff6f66f64677d4dd6fff77761005dddd5567777777777777777777777777777777777
7777777777777777777777777777777777777777610000005f7f655ddd66666666d467776dddd66ff77650015ddd555677777777777777777777777777777777
77777777777777777777777777777777777777777750000d776d665555dd6666664d7777777666dddd67750005dddd55d6777777777777777777777777777777
77777777777777777777777777777777777777777554006fd66777d5554dd66dd4d7777777777777777777d100155dddd5567777777777777777777777777777
7777777777777777777777777777777777777776545156f46777777776d66ddd667777777777777777777776510055dd5d55d777777777777777777777777777
77777777777777777777777777777777777777ddd51dfd477777777777777777777777777777777777777777f450055d55dd55d7777777777777777777777777
7777777777777777777777777777777777776d54056fdd77777777777777777777777777777777777777777777651005d555dd55677777777777777777777777
7777777777777777777777777777777777761550d6f467777777777777777777777777777777777777777777777765005d5555d5567777777777777777777777
777777777777777777777777777777777611515df64777777777777777777777777777777777777777777777777777d00555015dd5d777777777777777777777
77777777777777777777777777777777600555665d77777777777777777777777777777777777777777777777777777f55151001dd5567777777777777777777
7777777777777777777777677777776d00555d6dd666677777777777777777777777777777777777777777777777777776d5dd0005dd55677777777777777777
777777777777777777776d00567765000555d6d5551055d67777777777777777777777777777777777777777777777777776ddd50005d55d7777777777777777
7777777777777777d5110505d5d5101555ddd55555dddd5d6677777777777777777777777777777777777777777777777777765dd50005515677777777777777
77777777777777765d5dd55d10555d55d5450055544dd55d44d77777777777777777777777777777777777777777777777777776ddd100055057777777777777
777777777777777d6677761d55dddd45d6ddd67666676654654d77777777777777777777777777777777777777777777777777777ddd50005500677777777777
77777777777777776777777777777777777777777777777676566777777777777777777777777777777777777777777777777777777d55500051057777777777
77777777777777777777777777777777777777777777777777d6d777777777777777777777777777777777777777777777777777777765551001501777777777
777777777777777777777777777777777777777777777777776767777777777777777777777777777777777777777777777777777777776555000500d7777777
77777777777777777777777777777777777777777777777777776777777777777777777777777777777777777777777777777777777777775111000105777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777650100010577777
7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777d000001106777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777750000151d77
7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777d50000dd57
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777755501777
7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777f77dd77
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
