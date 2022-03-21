import math

def hex_to_bin(input):
    bin_str = ""
    for ch in input:
        val = int(ch, 16)
        bin_str += "{0:b}".format(val).zfill(4)
    return bin_str

def part1b(p_str, index = 0):
    print(p_str[index:index + 80])
    print(index)
    p_ver = int(p_str[index:index + 3], 2)
    p_type = int(p_str[index + 3:index + 6], 2)
    if p_type == 4:
        print(f'literal')
        val_str = ""
        done = False
        start_idx = index + 6
        end_idx = start_idx + 5
        while not done:
            chunk = p_str[start_idx:end_idx]
            val_str += chunk[1:5]
            if chunk[0] == '1':
                start_idx = end_idx
                end_idx += 5
            else:
                done = True
                print(f'literal value {int(val_str, 2)}')
        print(f'version - {p_ver}')
        return (p_ver, end_idx)
    else:
        print(f'operator')
        if p_str[index + 6] == '0':
            p_bits = int(p_str[index + 7:index + 22], 2)
            print(f'bits - {p_str[index + 7:index + 22]}')
            end_idx = index + 22 + p_bits
            sub_idx = index + 22
            print(f'op - bits {p_bits}')
            if p_bits > len(p_str):
                raise ValueError("bits longer than string")
            while sub_idx < end_idx:
                (sub_ver, sub_idx) = part1b(p_str, sub_idx)
                p_ver += sub_ver
            print(f'version - {p_ver}')
            return (p_ver, end_idx)
        else:
            p_count = int(p_str[index + 7:index + 18], 2)
            print(f'count - {p_str[index + 7:index + 18]}')
            print(f'op - count {p_count}')
            if (p_count * 11) > len(p_str):
                raise ValueError("count longer than string")
            sub_idx = index + 18
            while p_count > 0:
                (sub_ver, sub_idx) = part1b(p_str, sub_idx)
                p_ver += sub_ver
                p_count -= 1
            print(f'version - {p_ver}')
            return (p_ver, sub_idx)

def part2(p_str, index = 0):
    print(p_str[index:index + 80])
    print(index)
    p_ver = int(p_str[index:index + 3], 2)
    p_type = int(p_str[index + 3:index + 6], 2)
    if p_type == 4:
        print(f'literal')
        val_str = ""
        done = False
        start_idx = index + 6
        end_idx = start_idx + 5
        while not done:
            chunk = p_str[start_idx:end_idx]
            val_str += chunk[1:5]
            if chunk[0] == '1':
                start_idx = end_idx
                end_idx += 5
            else:
                done = True
                print(f'literal value {int(val_str, 2)}')
        print(f'version - {p_ver}')
        return (int(val_str, 2), end_idx)
    else:
        print(f'operator')
        vals = []
        end_idx = 0
        if p_str[index + 6] == '0':
            p_bits = int(p_str[index + 7:index + 22], 2)
            print(f'bits - {p_str[index + 7:index + 22]}')
            end_idx = index + 22 + p_bits
            sub_idx = index + 22
            print(f'op - bits {p_bits}')
            if p_bits > len(p_str):
                raise ValueError("bits longer than string")
            while sub_idx < end_idx:
                (sub_val, sub_idx) = part2(p_str, sub_idx)
                vals.append(sub_val)
            #print(f'version - {p_ver}')
            #return (p_ver, end_idx)
        else:
            p_count = int(p_str[index + 7:index + 18], 2)
            print(f'count - {p_str[index + 7:index + 18]}')
            print(f'op - count {p_count}')
            if (p_count * 11) > len(p_str):
                raise ValueError("count longer than string")
            sub_idx = index + 18
            while p_count > 0:
                (sub_val, sub_idx) = part2(p_str, sub_idx)
                print(f'val - {sub_val}, end - {sub_idx}')
                vals.append(sub_val)
                p_count -= 1
                end_idx = sub_idx
            #print(f'version - {p_ver}')
            #return (p_ver, sub_idx)
        if p_type == 0:
            return (sum(vals), end_idx)
        if p_type == 1:
            return(math.prod(vals), end_idx)
        if p_type == 2:
            return(min(vals), end_idx)
        if p_type == 3:
            return(max(vals), end_idx)
        if p_type == 5:
            val = 0
            if vals[0] > vals[1]:
                val = 1
            return(val, end_idx)
        if p_type == 6:
            val = 0
            if vals[0] < vals[1]:
                val = 1
            return(val, end_idx)
        if p_type == 7:
            val = 0
            if vals[0] == vals[1]:
                val = 1
            return(val, end_idx)

if __name__ == "__main__":
    infile = open('input.txt', 'r')
    input = infile.read()
    infile.close()
    print(part2(hex_to_bin(input)))
    # print(part1b(hex_to_bin(input)))
    #print(len(hex_to_bin(input)))
    #print(part1b(hex_to_bin("8A004A801A8002F478")))
    #print(part1b(hex_to_bin("620080001611562C8802118E34")))
    #print(part1b(hex_to_bin("C0015000016115A2E0802F182340")))
    #print(part1b(hex_to_bin("A0016C880162017C3686B18A3D4780")))
    # print(part2(hex_to_bin("C200B40A82")))
    # print(part2(hex_to_bin("04005AC33890")))
    # print(part2(hex_to_bin("880086C3E88112")))
    # print(part2(hex_to_bin("CE00C43D881120")))
    # print(part2(hex_to_bin("D8005AC2A8F0")))
    # print(part2(hex_to_bin("F600BC2D8F")))
    # print(part2(hex_to_bin("9C005AC2F8F0")))
    # print(part2(hex_to_bin("9C0141080250320F1802104A08")))