import Test.Hspec
import Lib


main :: IO ()
main = hspec $ do
    let sample = [199,200,208,210,200,207,240,269,260,263]
    describe "day one" $ do
        it "returns correct increment count" $ do
            countIncr sample `shouldBe` 7



