import UIKit

class Solution {
  func reverseWords(_ s: String) -> String {
    var rValue = ""
    for string in s.split(separator: " ") {
      rValue += string.reversed()
      rValue += " "
    }

    return rValue.trimmingCharacters(in: [" "])
  }
}

print(Solution().reverseWords("Let's take LeetCode contest"))

