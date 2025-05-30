from abc import ABC, abstractmethod

class HeapAbstract(ABC):
    def __init__(self):
        self.heap = []

    def parent(self, index) -> int | None:
        if index == 0:
            return None
        return (index - 1) // 2

    def leftChild(self, index) -> int | None:
        res = 2*index + 1
        if res >= len(self.heap):
            return None
        else:
            return res

    def rightChild(self, index) -> int | None:
        res = 2*index + 2
        if res >= len(self.heap):
            return None
        else:
            return res

    def push(self, value) -> None:
        self.heap.append(value)
        self._siftup(len(self.heap) - 1)

    def pop(self) -> int | None:
        if not self.heap:
            return None
        self.heap[0], self.heap[-1] = self.heap[-1], self.heap[0]
        value = self.heap.pop()
        if self.heap:
            self._shiftdown(0)
        return value
        
    def _siftup(self, index) -> None:
        parent_idx = self.parent(index)
        if self._should_swap(parent_idx, index):
            self.heap[parent_idx], self.heap[index] = self.heap[index], self.heap[parent_idx]
            self._siftup(parent_idx)

    def heapify(self) -> None:
        if not self.heap:
            return

        # Start from the last non-leaf node and move upwards
        for i in range(len(self.heap) // 2 - 1, -1, -1):
            self._shiftdown(i)

    @staticmethod
    @abstractmethod
    def from_array(values):
        pass

    @abstractmethod
    def _should_swap(self, parent_idx, child_idx) -> bool:
        pass

    def _shiftdown(self, i) -> None:
        to_shiftdown = i
        left = self.leftChild(i)
        right = self.rightChild(i)
        
        if self._should_swap(to_shiftdown, left):
            to_shiftdown = left
            
        if self._should_swap(to_shiftdown, right):
            to_shiftdown = right
            
        if to_shiftdown != i:
            self.heap[i], self.heap[to_shiftdown] = self.heap[to_shiftdown], self.heap[i]
            self._shiftdown(to_shiftdown)

class MinHeap(HeapAbstract):
    def __init__(self):
        super().__init__()

    @staticmethod
    def from_array(values):
        heap = MinHeap()
        heap.heap = values.copy()
        heap.heapify()
        return heap

    def _should_swap(self, parent_idx, child_idx) -> bool:
        return self.heap and child_idx is not None and parent_idx is not None and self.heap[parent_idx] > self.heap[child_idx]

class MaxHeap(HeapAbstract):
    def __init__(self):
        super().__init__()

    @staticmethod
    def from_array(values):
        heap = MaxHeap()
        heap.heap = values.copy()
        heap.heapify()
        return heap
    
    def _should_swap(self, parent_idx, child_idx) -> bool:
        return self.heap and child_idx is not None and parent_idx is not None and self.heap[parent_idx] < self.heap[child_idx]

# Example usage
if __name__ == "__main__":
    min_heap = MinHeap()
    for val in [5, 3, 8, 1, 2, 9]:
        min_heap.push(val)
    print("Min heap:", min_heap.heap)
    
    values = [5, 3, 8, 1, 2, 9]
    max_heap = MaxHeap.from_array(values)
    print("Max heap:", max_heap.heap)
    
    print("Popping from min heap:", [min_heap.pop() for _ in range(len(min_heap.heap) + 1)])

