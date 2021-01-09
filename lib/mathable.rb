module Mathable

  def average(sum, total)
    (sum / total.to_f).round(2)
  end

  def percentage(sum, total)
    ((sum / total.to_f) * 100).round(2)
  end

  def difference_of_each_x_and_y(num1, num2)
    num1.map do |i|
      i - num2
    end
  end

  def squares_of_differences(num)
    num.map do |difference|
      (difference ** 2).round(4)
    end
  end

  def sum_of_square_differences(num)
    sum_of_squares = num.map do |difference|
      difference ** 2
    end
    sum_of_squares.sum
  end

  def std_dev_variance(num)
    num.count - 1
  end

  def sum_and_variance_quotient(sum_of_square_differences, std_dev_variance)
    sum_of_square_differences / std_dev_variance
  end

  def standard_deviation(sum_and_variance_quotient)
    (sum_and_variance_quotient ** 0.5).round(2)
  end

  def final_std_dev(num1, num2)
    a = (difference_of_each_x_and_y(num1, num2))
    b = (squares_of_differences(a))
    c = (b.sum)
    d = (std_dev_variance(num1))
    e = (sum_and_variance_quotient(c, d))
    (standard_deviation(e))
  end

end
