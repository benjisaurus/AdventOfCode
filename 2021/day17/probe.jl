function calc_vel_x(vel_x)
    if vel_x > 0
        vel_x - 1
    elseif vel_x < 0
        vel_x + 1
    else
        0
    end
end

function next_position(start_x, start_y, vel_x, vel_y, high_y)
    new_x = start_x + vel_x
    new_y = start_y + vel_y
    new_vel_x = calc_vel_x(vel_x)
    new_vel_y = vel_y - 1
    new_high_y = if new_y > high_y
        new_y
    else
        high_y
    end
    (new_x, new_y, new_vel_x, new_vel_y, new_high_y)
end