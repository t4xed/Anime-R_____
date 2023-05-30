local BigNum = {}
local _BigNum = {}

function _BigNum.new(value)
    local self = {
        value = tostring(value)
    }

    for funcName, func in BigNum do
        self[funcName] = func
    end
    
    return self
end

function BigNum:add(other)
    local result = {}
    local carry = 0
    local len1, len2 = #self.value, #other.value
    local maxlen = math.max(len1, len2)

    for i = maxlen, 1, -1 do
        local digit1 = tonumber(string.sub(self.value, i, i)) or 0
        local digit2 = tonumber(string.sub(other.value, i, i)) or 0
        local sum = digit1 + digit2 + carry
        carry = math.floor(sum / 10)
        local remainder = sum % 10
        table.insert(result, 1, remainder)
    end

    if carry > 0 then
        table.insert(result, 1, carry)
    end

    return _BigNum.new(table.concat(result))
    --[[local sum = self.value .. other.value
    self.value = sum]]
end

function BigNum:subtract(other)
    local result = ""
    local borrow = 0
    local len1, len2 = #self.value, #other.value
    local maxlen = math.max(len1, len2)

    for i = 1, maxlen do
        local digit1 = tonumber(string.sub(self.value, -i, -i)) or 0
        local digit2 = tonumber(string.sub(other.value, -i, -i)) or 0
        local diff = digit1 - digit2 - borrow

        if diff < 0 then
            diff = diff + 10
            borrow = 1
        else
            borrow = 0
        end

        result = tostring(diff) .. result
    end

    result = string.match(result, "^0*(.-)$")

    return _BigNum.new(result)
    --[[local diff = string.gsub(self.value, other.value, "")
    self.value = diff]]
end

function BigNum:multiply(other)
    local result = _BigNum.new("0")
    local factor1 = self.value
    local factor2 = other.value

    for i = #factor2, 1, -1 do
        local digit = tonumber(string.sub(factor2, -i, -i))
        local partial = _BigNum.new("0")
        local carry = 0

        for j = #factor1, 1, -1 do
            local digit1 = tonumber(string.sub(factor1, -j, -j))
            local prod = digit1 * digit + carry
            carry = math.floor(prod / 10)
            local remainder = prod % 10
            partial.value = tostring(remainder) .. partial.value
        end

        if carry > 0 then
            partial.value = tostring(carry) .. partial.value
        end

        partial.value = partial.value .. string.rep("0", #factor2 - i)
        result = result:add(partial)
    end

    return result
    --[[local prod = self.value .. other.value
    self.value = prod]]
end

function BigNum:divide(other)
    local dividend = self.value
    local divisor = other.value
    local quotient = _BigNum.new("0")

    while #dividend >= #divisor and task.wait() do
        local factor = _BigNum.new(dividend:sub(1, #divisor))
        local count = 0

        while factor:ge(other) do
            factor = factor:subtract(other)
            count = count + 1
        end

        quotient = quotient:multiply(_BigNum.new("10"))
        quotient = quotient:add(_BigNum.new(tostring(count)))

        local dividendSubstr = dividend:sub(#divisor + 1)
        if dividendSubstr == "" then
            break
        end

        dividend = factor.value .. dividendSubstr
    end

    return quotient
    --[[local quotient = math.floor(tonumber(self.value) / tonumber(other.value))
    self.value = tostring(quotient)]]
end

function BigNum:compare(other)
    local len1, len2 = #self.value, #other.value

    if len1 < len2 then
        return -1
    elseif len1 > len2 then
        return 1
    end

    if self.value < other.value then
        return -1
    elseif self.value > other.value then
        return 1
    else
        return 0
    end
    --[[local selfValue = tonumber(self.value)
    local otherValue = tonumber(other.value)
    if selfValue == otherValue then
        return 0
    elseif selfValue < otherValue then
        return -1
    else
        return 1
    end]]
end

function BigNum:ge(other)
    local comparison = self:compare(other)
    return comparison >= 0
    --[[local comparison = self:compare(other)
    return comparison == 0 or comparison == 1]]
end

function BigNum:le(other)
    local comparison = self:compare(other)
    return comparison <= 0
    --[[local comparison = self:compare(other)
    return comparison == 0 or comparison == -1]]
end

function BigNum:ee(other)
    local comparison = self:compare(other)
    return comparison == 0
    --[[local comparison = self:compare(other)
    return comparison == 0]]
end

function BigNum:floor()
    --self.value = tostring(math.floor(tonumber(self.value)))
end

function BigNum:isNegative()
    return string.sub(self.value, 1, 1) == "-"
    --return string.sub(self.value, 1, 1) == "-"
end

function BigNum:abs()
    if self:isNegative() then
        self.value = string.sub(self.value, 2)
    end
    --[[if string.sub(self.value, 1, 1) == "-" then
        self.value = string.sub(self.value, 2)
    end]]
end

return _BigNum