/*
 From Swift Algorithm Club:
 https://github.com/raywenderlich/swift-algorithm-club/blob/master/Queue/
 
 First-in first-out queue (FIFO)
 New elements are added to the end of the queue. Dequeuing pulls elements from
 the front of the queue.
 Enqueuing and dequeuing are O(1) operations.
 
 */
public struct SizedQueue<T> {
    fileprivate var array = [T?]()
    fileprivate var head = 0
    
    private var max_size: Int!
    
    
    /// Creates a SizedQueue that
    ///
    /// - Parameter size: the maximum number of values that can be stored in the Queue at a given time.
    init(size: Int) {
        max_size = size
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    
    /// Enqueues an element and removes any other elements if there is more than MAX_SIZE elements in the Queue
    ///
    /// - Parameter element: Element being entered into the queue
    public mutating func enqueue(_ element: T) {
        array.append(element)
        if array.count > max_size {
            _ = dequeue()
        }
    }
    
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head)/Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
    
    public func peek(_ index: Int) -> T? {
        return array[head+index]
    }
}
