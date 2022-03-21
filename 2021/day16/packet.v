import strconv { parse_uint }

fn hex_to_bin(h string) string {
	num := strconv.parse_uint(h, 16, 64) or { 0 }
	return '${num:b}'
}

fn parse_literal(payload string) u64 {
	p_len := payload.len
	mut lit_num := ""
	mut i := 0
    for p_len - i >= 5 {
        lit_num += payload[i+1..i+5]
		if payload[i] == 0 {
			i = p_len
		} else {
			i += 5
		}
	}

	return strconv.parse_uint(lit_num, 2, 64) or { 0 }
}

fn part1(input string) u64 {
	bin_str := hex_to_bin(input)
	println(bin_str)
	version := strconv.parse_uint(bin_str[0..3], 2, 64) or { 0 }
	p_type := strconv.parse_uint(bin_str[3..6], 2, 64) or { 0 }
	if p_type == 4 {
        return version
	} else {
		len_type := input[6]
		if len_type == `0` {
			len := strconv.parse_uint(bin_str[7..22],2,64) or { 0 }
			return version + part1(bin_str[23..23+len])
		} else {
			return version + 10
		}
	}
	
}

fn main() {
	//println(hex_to_bin("D2FE28"))
	//println(parse_literal("101111111000101000"))
	println(part1("38006F45291200"))
	//println(hex_to_bin("38006F45291200"))
}