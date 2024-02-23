class Dog{
    var name : String
    init(name : String) {
        self.name = name
        print("\(name) is initialized")
    }
    deinit {
        print("\(name) is deinitialized")
    }
}

class Bone{
    var owner : Dog
    init(owner : Dog) {
        self.owner = owner
        print("bone is initialized")
    }
    deinit {
        print("bone is deinitialized")
    }
}


var lucky : Dog? = Dog(name: "Lucky")

weak var bone : Bone? = Bone(owner: lucky!)
print(lucky?.name)

print(bone?.owner.name)

lucky = nil

print(lucky?.name)

print(bone?.owner.name)
