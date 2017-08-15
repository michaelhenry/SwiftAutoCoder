// https://github.com/Quick/Quick

import Quick
import Nimble
import SwiftAutoCoder

class User:NSObject, NSCoding {

    var name:String = ""
    var age:Int = 0
    var staff:Bool = false
    
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        autoDecode(aDecoder)
    }
    
    func encode(with aCoder: NSCoder) {
        autoEncode(with: aCoder)
    }
}

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        
        describe("Check it") {
            
            it("can archive/unarchive object") {
                let name = "マイケルヘンリー 😎 :)"
                let me = User(name: name, age: 119)
                me.staff = true
                let data = NSKeyedArchiver.archivedData(withRootObject: me)
                let theSameMe = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
                
                expect(theSameMe.name) == name
                expect(theSameMe.age) == 119
                expect(theSameMe.staff) == true
                
            }
        }
    }
}
