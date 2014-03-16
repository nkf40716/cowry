# ����˼��1��
# �����Ҫ�ռ���O(1) (ԭ����O(n)
# �����ȱ���һ�飬���Ƿ���linked
# Ȼ���۰����linked�ĵ�
# ʱ�临�Ӷ���O(n)��ΪO(nlgn)
#
# ����˼��2��
# ����������
# http://blog.csdn.net/sysucph/article/details/15378043

class Solution:
    # @param head, a ListNode
    # @return a list node
    def detectCycle(self, head):
        nodes = set()
        while head:
            if head in nodes:
                return head
            nodes.add(head)
            head = head.next
arr = [1,2,3,4,5]
r = build_list(arr)
print Solution().detectCycle(r)
r.next.next = r
print Solution().detectCycle(r)