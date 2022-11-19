using ArgParse, HTTP, Dates, TimeZones

# only 2022 for now
const YEAR = 2022
const URL = "https://adventofcode.com/$YEAR/day/"

# session cookie should be stored in .session_token file
# how to get cookie: https://github.com/wimglenn/advent-of-code-wim/issues/1
const SESSION_AUTH = Dict("session"=>open(readline, ".session_token"))

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--day", "-d"
            help = "day number for the input to be downloaded. If not given take today's input"
            arg_type = Int
            range_tester = x -> 1 <= x <=25
    end

    return parse_args(s)
end

function timeleft(nday)
    Δt = DateTime(YEAR, 12, nday) - DateTime(now(tz"UTC-5"))
    Δt = round(Δt, Second)
    Δt.value > 86400 && return round(Δt, Day)
    Δt.value > 3600 && return round(Δt, Hour)
    Δt.value > 120 && return round(Δt, Minute)
    return Δt
end

default_day() = min(today(), Date(YEAR, 12, 25)) |> day

function main()
    parsed_args = parse_commandline()
    nday = parsed_args["day"]
    if isnothing(nday) nday = default_day() end

    filename = "data/input$nday.txt"

    if nday > day(today(tz"UTC-5"))
         @error "input for day $nday not ready yet (UTC-5). Time left: $(timeleft(nday))"
         return
    elseif isfile(filename)
        @warn "input file for day $nday exists. Skipping request..."
        return
    end

    io = open(filename, "w")
    day_url = URL * "$nday/input"
    response = HTTP.get(day_url; cookies=SESSION_AUTH, response_stream=io)
    if response.status == 200
        @info "input for day $nday downloaded and written to file $filename"
    else
        @error "HTTP request failed with status code $response.status"
        return
    end
    close(io)
end

main()
