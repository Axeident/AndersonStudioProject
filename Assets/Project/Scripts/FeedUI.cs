using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FeedUI : MonoBehaviour
{
    public int transition;
    // Start is called before the first frame update
    void Awake()
    {
        gameObject.GetComponentInParent<UI_Text>().Update_UI(transition);
    }
}
