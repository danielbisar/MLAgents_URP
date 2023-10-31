using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;

public class AgentTailBehavior : MonoBehaviour
{
    public float LifeTimeS = 1f;
    public bool IsOriginal { get; set; } = true;
    private float _startTime;
    
    
    // Start is called before the first frame update
    void Start()
    {
        _startTime = Time.time;
    }

    // Update is called once per frame
    void Update()
    {
        if (IsOriginal)
            return;
        
        if(Time.time - _startTime > LifeTimeS)
            Destroy(gameObject);
    }
}
