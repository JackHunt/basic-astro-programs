function val = inputInRange(prompt, min, max)
    val = input(prompt);
    while val < min || val > max
        clc;
        val = input(prompt);
    end
end

