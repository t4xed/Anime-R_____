local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BigNum = require(ReplicatedStorage.Cryptware.BigNum)
local AbbreviateModule = {}

AbbreviateModule.Suffixes = {"K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "O", "N", "Dc", "Ud", "Dd", "Td", "Qtd", "Qn", "Sd", "St", "Oc", "Nv", "Vg", "Ug", "Dg", "Tg", "Qtg", "Qng", "Sv", "Spd", "Ocd", "Nvd", "Vn", "Un", "Dn", "Tsn", "Qtsn", "Qnsn", "Ssn", "Spn", "Ocn", "Nn", "Qd", "Uqd", "Dqd", "Tqd", "Qdq", "Qnq", "Sdq", "Spq", "Oqd", "Nqd", "Qg", "Uqg", "Dqg", "Tqg", "Qdqg", "Qnqg", "Sqg", "Spqg", "Oqg", "Nqg", "Sgl", "Qc", "Uqc", "Dqc", "Tqc", "Qdqc", "Qnqc", "Sdqc", "Spqc", "Oqc", "Nqc", "Ss", "Usd", "Dsd", "Tsd", "Qdsd", "Qnsd", "Sdsd", "Spsd", "Osd", "Nsd", "Sq", "Usq", "Dsq", "Tsq", "Qdsq", "Qnsq", "Sdsq", "Spsq", "Osq", "Nsq", "Sm", "Usm", "Dsm", "Tsm", "Qdsm", "Qnsm", "Sdsm", "Spsm", "Osm", "Nsm", "Sn", "Usn", "Dsn", "Tsn", "Ts", "Dp", "Tp", "Qtp", "Opq", "Qt", "Uq", "Dq", "Tq", "Sqp", "Np", "Qnp"}

function AbbreviateModule:Abbreviate(Input)
	local Paired = false
	for i,_ in pairs(AbbreviateModule.Suffixes) do
		if not (Input >= BigNum.new(10^(3*i))) then
			Input = Input / BigNum.new(10^(3*(i-1)))
			local isComplex = (string.find(tostring(Input),".") and string.sub(tostring(Input),4,4) ~= ".")
			Input = string.sub(tostring(Input),1,(isComplex and 4) or 3) .. (AbbreviateModule.Suffixes[i-1] or "")
			Paired = true
			break;
		end
	end
	if not Paired then
		local Rounded = math.floor(Input)
		Input = tostring(Rounded)
	end
	return Input
end

return AbbreviateModule